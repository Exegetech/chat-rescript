const fs = require('node:fs');
const { promisify } = require('node:util');
const { join } = require('node:path');
const esbuild = require('esbuild')

const rootDir = join(__dirname, '..')
const outDir = join(rootDir, 'dist')

const readFile = promisify(fs.readFile)
const writeFile = promisify(fs.writeFile)

function getDependenciesToBundle(dep) {
  const isRescriptDeps = /rescript/.test(dep[0])
  const isWorkspaceDeps = dep[1].startsWith('workspace')

  return !(isRescriptDeps || isWorkspaceDeps)
}

async function getDependencies() {
  const pkgJsonPath = join(rootDir, 'package.json')
  const json = await readFile(pkgJsonPath, 'utf-8')
  const obj = JSON.parse(json)
  const deps = Object.entries(obj.dependencies)

  return deps.filter(getDependenciesToBundle)
}

function makeBuildPkgJson(deps) {
  const obj = {
    scripts: {
      start: "node index.mjs"
    },
    dependencies: deps.reduce((acc, dep) => {
      acc[dep[0]] = dep[1]
      return acc
    }, {})
  }

  return obj
}

async function build() {
  const deps = await getDependencies()
  const external = deps.map((dep) => dep[0])

  await esbuild.build({
    entryPoints: [join(rootDir, 'src/Server.bs.mjs')],
    bundle: true,
    format: 'esm',
    platform: 'node',
    external,
    outfile: join(outDir, 'index.mjs'),
  })

  const buildJson = makeBuildPkgJson(deps)
  const stringified = JSON.stringify(buildJson, null, 2)
  await writeFile(join(outDir, 'package.json'), stringified)
}

build()

