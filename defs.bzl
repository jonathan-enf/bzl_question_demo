DataFileProvider = provider(
  fields = {
    "src": "a source file.",
    "deps": "a depset of source files from transitive dependencies",
  }
)

def _datafile_impl(ctx):
  all_deps = depset(
    direct = ctx.files.src,
    transitive = [
      dep[DataFileProvider].deps for dep in ctx.attr.deps
    ],
  )
  return [
    DataFileProvider(
      src = ctx.files.src,
      deps = all_deps,
    ),
    DefaultInfo(
      files = all_deps,
    ),
  ]

datafile = rule(
    implementation = _datafile_impl,
    attrs = {
        "src": attr.label(
            doc = "Source file.",
            mandatory = False,
            allow_files = True,
        ),
        "deps": attr.label_list(
            doc = "List of dependencies",
            mandatory = False,
            allow_files = False,
            providers = [DataFileProvider],
        ),
    },
)

def _pygen_impl(ctx):
  src = ctx.attr.src[DataFileProvider].src
  deps = ctx.attr.src[DataFileProvider].deps
  inputs = src
  outputs = [ctx.outputs.out]
  dep_modules = [x.path for x in deps.to_list()]
  arguments = [x.path for x in src] + [ctx.outputs.out.path] + dep_modules
  ctx.actions.run(
    inputs = inputs,
    outputs = outputs,
    arguments = arguments,
    executable = ctx.executable._tool,
  )
  return [
    DefaultInfo(
      files = depset([ctx.outputs.out])
    )
  ]

pygen = rule(
  implementation = _pygen_impl,
  attrs = {
    "src": attr.label(
      mandatory = True,
      allow_files = False,
      providers = [DataFileProvider],
    ),
    "out": attr.output(
      mandatory = True,
    ),
    "_tool": attr.label(
      default = Label("//:pygen"),
      executable = True,
      cfg = "exec",
      allow_files = True,
    ),
  },
)



