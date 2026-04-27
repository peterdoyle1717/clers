# clers

CBEAD/CLERS encode/decode and canonical naming for triangulations of the sphere.

This repository contains small standalone C and Python implementations of a CLERS-style traversal code for sphere triangulations. In the code and examples here, the alphabet is written in the **CBEAD** variant rather than the classical **CLERS** lettering used in the Edgebreaker literature.

The correspondence is:

- classical `C L E R S`
- here `C B E A D`

So references to CLERS in the literature correspond here to CBEAD in the code.

For us, this traversal code is useful not just as a compact encoding, but as an assembly order for actually building a polyhedron face by face.

The implementation here is in the Edgebreaker / corner-table tradition, but the emphasis is different from production mesh codecs: exact encode/decode for triangulations of the sphere, canonical names, and simple batch tools.

## What is here

- `src/clers.c`:
  - batch command-line tool
  - decodes CBEAD/CLERS names to face lists
  - encodes face lists to traversal names
  - computes canonical traversal names
- `src/clers.py`:
  - reference-quality Python implementation
  - iterative encode/decode
  - canonical naming in both oriented and unoriented forms

## Alphabet

This repository uses the letters

- `C`
- `B`
- `E`
- `A`
- `D`

which correspond to the classical Edgebreaker / CLERS letters

- `C`
- `L`
- `E`
- `R`
- `S`

respectively.

## Scope

Input objects are triangulations of the sphere. A triangulation is represented as a list of triples `(a,b,c)` with vertices labeled `1..n`, and each oriented edge `(a,b)` belongs to exactly one face `(a,b,c)`.

## C tool

Compile with:

```bash
make
```

This builds `bin/clers`. The executable supports four modes:

```bash
bin/clers decode
bin/clers encode
bin/clers name
bin/clers canonical
```

Meanings:

- `decode`: traversal name -> face list
- `encode`: face list -> one traversal name
- `name`: face list -> canonical traversal name
- `canonical`: traversal name -> canonical traversal name

Input is one object per line on stdin.

Face-list format is:

```text
a,b,c;d,e,f;...
```

Example:

```bash
echo '1,2,3;1,3,4;1,4,2;2,4,3' | bin/clers name
```

## Python module

The Python file at `src/clers.py` provides the main functions:

- `encode(poly, start=None)`
- `decode(recipe, verify=False)`
- `official_name(poly)`
- `official_unoriented_name(poly)`

The implementations are iterative rather than recursive.

Example (from the repo root, with `src/` on `PYTHONPATH`):

```python
import sys; sys.path.insert(0, "src")
from clers import encode, decode, official_name, official_unoriented_name

tet = [(1,2,3),(1,3,4),(1,4,2),(2,4,3)]

name = official_unoriented_name(tet)
poly = decode(name, verify=True)

print(name)
print(poly)
```

## Canonical naming

Canonical names are obtained by minimizing over starts at minimum-degree vertices; in the unoriented case, both orientations are considered.

This makes the code useful not only for encode/decode, but also for:

- naming triangulated spheres
- deduplicating generated nets
- detecting isomorphism of embedded triangulations
- maintaining stable names in enumeration pipelines

## Why this repo exists

A spiral code is attractive when it works, but it breaks down as a general naming scheme. CBEAD/CLERS gives a compact local traversal code that is easy to decode, useful for actual face-by-face construction, and flexible enough to support canonical naming.

That combination makes it a good fit for triangulated-sphere workflows in which one wants all of the following:

- generation
- encode/decode
- canonical names
- isomorphism detection
- human-readable build order

## Notes

This repository is intentionally small and transparent. It is not trying to be a full industrial mesh-compression library. The point is to have a simple, exact, hackable implementation for triangulations of the sphere.

## Keywords

CBEAD, CLERS, Edgebreaker, corner table, triangulation, sphere triangulation, canonical naming, canonical labeling, graph encoding, polyhedra.
