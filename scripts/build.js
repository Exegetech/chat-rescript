const path = require('node:path');
const concurrently = require('concurrently');

const rootDir = path.resolve(__dirname, '..')

concurrently(
  [
    // Cleanup
    {
      name: 'clean',
      command: 'rm -rf dist',
      cwd: rootDir,
    },

    // Build shared
    {
      name: 'shared/res:build',
      command: 'pnpm run res:build',
      cwd: path.resolve(rootDir, 'shared'),
    },

    // Build backend
    {
      name: 'backend/res:build',
      command: 'pnpm run res:build',
      cwd: path.resolve(rootDir, 'backend'),
    },
    {
      name: 'backend/build',
      command: 'pnpm run build',
      cwd: path.resolve(rootDir, 'backend'),
    },
    {
      name: 'move backend build',
      command: 'mv dist ../dist',
      cwd: path.resolve(rootDir, 'backend'),
    },
    {
      name: 'install backend dependencies',
      command: 'pnpm --ignore-workspace install',
      cwd: path.resolve(rootDir, 'dist'),
    },

    // Build frontend
    {
      name: 'frontend/res:build',
      command: 'pnpm run res:build',
      cwd: path.resolve(rootDir, 'frontend'),
    },
    {
      name: 'frontend/build',
      command: 'pnpm run build',
      cwd: path.resolve(rootDir, 'frontend'),
    },
    {
      name: 'move frontend build',
      command: 'mv dist ../dist/public',
      cwd: path.resolve(rootDir, 'frontend'),
    },
  ],
  {
    prefix: 'name',
    killOthers: ['failure', 'success'],
    restartTries: 3,
    maxProcesses: 1,
    prefixColors: 'auto',
  },
);

