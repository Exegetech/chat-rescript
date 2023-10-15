const path = require('node:path');
const concurrently = require('concurrently');

concurrently(
  [
    {
      name: 'shared/res:dev',
      command: 'pnpm run res:dev',
      cwd: path.resolve(__dirname, '../shared'),
    },
    {
      name: 'backend/res:dev',
      command: 'pnpm run res:dev',
      cwd: path.resolve(__dirname, '../backend'),
    },
    {
      name: 'backend/dev',
      command: 'pnpm run dev',
      cwd: path.resolve(__dirname, '../backend'),
    },
    {
      name: 'frontend/res:dev',
      command: 'pnpm run res:dev',
      cwd: path.resolve(__dirname, '../frontend'),
    },
    {
      name: 'frontend/dev',
      command: 'pnpm run dev',
      cwd: path.resolve(__dirname, '../frontend'),
    },
  ],
  {
    prefix: 'name',
    killOthers: ['failure', 'success'],
    restartTries: 3,
  },
);

