#!/usr/bin/python3
"""Produces a file like the following:

    #!/usr/bin/python3

    import b

    def sum():
      x = 11
      x = x + b.sum()
      return x
"""

import json
import sys

def main(args):
    ifile = args[0]
    ofile = args[1]
    deps = args[2:]
    deps = [d for d in deps if d != ifile]
    deps = [d.split(".")[0] for d in deps]

    with open(ifile, 'r', encoding='utf-8') as fd:
        data = json.load(fd)

    with open(ofile, 'w', encoding='utf-8') as fd:
        fd.write("\n".join(
            [
                "#!/usr/bin/python3",
                "",
            ] + [f"import {dep}" for dep in deps] + [
                "",
                "def sum():",
                f"  x = {data}",
            ] + [f"  x = x + {dep}.sum()" for dep in deps] + [
                "  return x",
                ""
            ]))

if __name__ == "__main__":
    main(sys.argv[1:])
