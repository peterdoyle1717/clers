# clers

CLERS encoding and decoding for triangulated spheres.

A triangulation of the sphere with all faces triangles can be encoded as a
string over the alphabet **`ABCDE`**, one character per face, by depth-first
traversal of a spanning tree of the triangle dual graph:

| char | meaning |
|---|---|
| `E` | leaf — both children already in tree |
| `A` | single child via the left edge |
| `B` | single child via the right edge |
| `C` | handle — single child closes a cycle |
| `D` | binary split — two children |

Encoding produces a canonical name (lex-first across choices of starting
edge and orientation). Decoding recovers the face list.

## Quick start

```bash
make                          # builds bin/clers
echo CCAE | bin/clers decode  # tetrahedron face list
echo "1,2,3;1,3,4;1,4,2;2,4,3" | bin/clers encode  # back to CCAE
```

```python
from src.clers import decode, encode, official_name
poly = decode("CCAE")              # [(1,2,3), (1,3,4), (1,4,2), (2,4,3)]
print(official_name(poly))         # "CCAE"
```

## Provenance

Canonical source extracted from `peterdoyle1717/undented` 2026-04-26.
Same `clers.{c,py}` that ran the v=4..50 prime enumeration end-to-end on
8.2M cases. Includes the bad-input safety fix (commit `f21296f` upstream)
that rejects characters outside `ABCDE` instead of hanging in an infinite
loop / silently producing wrong output.

## License

MIT — see `LICENSE`.
