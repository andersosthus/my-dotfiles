#!/usr/bin/env node
// Claude Code Statusline (custom)
// Layout: folder/subpath │ ⎇ branch ●/✓ ↑a↓b +a-r │ model │ +added -removed │ ⏳ 5h% · 7d% │ context-bar
// (git, lines-changed, and quota segments are each omitted when not applicable)
// The "+a-r" after the branch is the live working-tree diff vs HEAD (drops out
// when clean); the standalone "+added -removed" segment is the cumulative
// session total Claude Code reports and is monotonic by design.
//
// Reads the status JSON from stdin (see Claude Code statusLine docs).

const { execSync } = require('child_process');
const path = require('path');

// --- ANSI helpers -----------------------------------------------------------
const A = {
  reset: '\x1b[0m',
  dim: '\x1b[2m',
  bold: '\x1b[1m',
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  red: '\x1b[31m',
  magenta: '\x1b[35m',
  orange: '\x1b[38;5;208m',
  blink_red: '\x1b[5;31m',
};

// Run a git command in `cwd`, returning trimmed stdout or null on any failure.
function git(cwd, cmd) {
  try {
    return execSync(`git ${cmd}`, {
      cwd,
      encoding: 'utf8',
      stdio: ['ignore', 'pipe', 'ignore'],
      timeout: 250,
    }).trim();
  } catch {
    return null;
  }
}

// --- main --------------------------------------------------------------------
let input = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', c => (input += c));
process.stdin.on('end', () => {
  try {
    const data = JSON.parse(input);
    const model = data.model?.display_name || 'Claude';
    const dir = data.workspace?.current_dir || process.cwd();
    const remaining = data.context_window?.remaining_percentage;
    const added = data.cost?.total_lines_added || 0;
    const removed = data.cost?.total_lines_removed || 0;
    const rl = data.rate_limits || {};

    const segments = [];

    // --- Folder + git ---------------------------------------------------------
    const root = git(dir, 'rev-parse --show-toplevel');
    let folder;
    let gitSeg = '';

    if (root) {
      // Folder = repo name + relative subpath
      const repoName = path.basename(root);
      const sub = path.relative(root, dir);
      const folderText = sub ? `${repoName}/${sub}` : repoName;
      folder = `${A.cyan}${A.bold}${repoName}${A.reset}${sub ? `${A.dim}/${sub}${A.reset}` : ''}`;

      // Branch + dirty + ahead/behind from one status call
      const status = git(dir, 'status --porcelain=v1 --branch');
      if (status != null) {
        const lines = status.split('\n');
        const header = lines[0] || '';
        const changed = lines.slice(1).filter(l => l.trim().length > 0).length;

        // Parse branch + ahead/behind from "## main...origin/main [ahead 1, behind 2]"
        let branch = '';
        let ahead = 0;
        let behind = 0;
        const m = header.match(/^## (.+?)(?:\.\.\.|\s|$)/);
        if (m) branch = m[1];
        if (branch === 'HEAD') {
          // Detached — show short SHA instead
          const sha = git(dir, 'rev-parse --short HEAD');
          branch = sha ? `@${sha}` : 'detached';
        }
        const am = header.match(/ahead (\d+)/);
        const bm = header.match(/behind (\d+)/);
        if (am) ahead = parseInt(am[1], 10);
        if (bm) behind = parseInt(bm[1], 10);

        const dirty = changed > 0
          ? `${A.yellow}●${A.reset}`
          : `${A.green}✓${A.reset}`;

        let track = '';
        if (ahead) track += ` ${A.green}↑${ahead}${A.reset}`;
        if (behind) track += ` ${A.red}↓${behind}${A.reset}`;

        // Live working-tree diff vs HEAD (resets to nothing when clean).
        let diffSeg = '';
        const numstat = git(dir, 'diff HEAD --numstat');
        if (numstat) {
          let gitAdded = 0;
          let gitRemoved = 0;
          for (const l of numstat.split('\n')) {
            const [a, r] = l.split('\t');
            if (a !== '-' && a !== undefined) gitAdded += parseInt(a, 10) || 0;
            if (r !== '-' && r !== undefined) gitRemoved += parseInt(r, 10) || 0;
          }
          if (gitAdded || gitRemoved) {
            diffSeg = ` ${A.green}+${gitAdded}${A.reset}${A.red}-${gitRemoved}${A.reset}`;
          }
        }

        gitSeg = `${A.magenta}⎇ ${branch}${A.reset} ${dirty}${track}${diffSeg}`;
      }
    } else {
      folder = `${A.cyan}${A.bold}${path.basename(dir)}${A.reset}`;
    }

    segments.push(folder);
    if (gitSeg) segments.push(gitSeg);

    // --- Model ----------------------------------------------------------------
    segments.push(`${A.dim}${model}${A.reset}`);

    // --- Lines changed --------------------------------------------------------
    if (added || removed) {
      segments.push(`${A.green}+${added}${A.reset} ${A.red}-${removed}${A.reset}`);
    }

    // --- Quota / rate limits (Pro/Max only; absent until first API response) --
    // Color a 0-100 usage % the same way as the context bar.
    const quotaColor = (pct) => {
      if (pct < 50) return A.green;
      if (pct < 75) return A.yellow;
      if (pct < 90) return A.orange;
      return A.red;
    };
    // Compact "time until reset" (e.g. "2h", "45m") from a Unix epoch; shown
    // only when usage is critical so the statusline stays terse otherwise.
    const resetIn = (epoch) => {
      if (epoch == null) return '';
      const secs = epoch - Math.floor(Date.now() / 1000);
      if (secs <= 0) return ' (resets now)';
      const h = Math.floor(secs / 3600);
      const m = Math.floor((secs % 3600) / 60);
      let span;
      if (h >= 24) {
        const d = Math.floor(h / 24);
        span = `${d}d ${h % 24}h`;
      } else if (h > 0) {
        span = `${h}h${m > 0 ? ` ${m}m` : ''}`;
      } else {
        span = `${m}m`;
      }
      return ` (resets ${span})`;
    };
    const quotaPart = (label, win) => {
      const pct = win?.used_percentage;
      if (pct == null) return null;
      const c = quotaColor(pct);
      const reset = pct >= 90 ? `${A.dim}${resetIn(win.resets_at)}${A.reset}` : '';
      return `${A.dim}${label}${A.reset} ${c}${Math.round(pct)}%${A.reset}${reset}`;
    };
    const quotaParts = [
      quotaPart('5h', rl.five_hour),
      quotaPart('7d', rl.seven_day),
    ].filter(Boolean);
    if (quotaParts.length) {
      segments.push(`${A.dim}⏳${A.reset} ${quotaParts.join(`${A.dim} · ${A.reset}`)}`);
    }

    // --- Context bar (scaled to the 80% real limit = 100% displayed) ----------
    if (remaining != null) {
      const rem = Math.round(remaining);
      const rawUsed = Math.max(0, Math.min(100, 100 - rem));
      const used = Math.min(100, Math.round((rawUsed / 80) * 100));
      const filled = Math.floor(used / 10);
      const bar = '█'.repeat(filled) + '░'.repeat(10 - filled);

      let ctx;
      if (used < 63) ctx = `${A.green}${bar} ${used}%${A.reset}`;
      else if (used < 81) ctx = `${A.yellow}${bar} ${used}%${A.reset}`;
      else if (used < 95) ctx = `${A.orange}${bar} ${used}%${A.reset}`;
      else ctx = `${A.blink_red}💀 ${bar} ${used}%${A.reset}`;
      segments.push(ctx);
    }

    process.stdout.write(segments.join(`${A.dim} │ ${A.reset}`));
  } catch {
    // Silent fail — never break the statusline.
  }
});
