<!--
author:   Alexander Botzki
email:    alexander.botzki@vib.be
version:  1.0.0
language: en
narrator: US English Female
link:     https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css

comment:  Compare the chains of two ATP-bound DnaK crystal structures (4JNE and 4B9Q) with ChimeraX matchmaker.
-->

# Exercise 4: Compare the chains of 4JNE and 4B9Q

DnaK (UniProt P0A6Y8) is the *E. coli* Hsp70 chaperone. Both entries below show **ATP-bound, full-length DnaK** in the open, domain-docked state, but they come from different crystals:

| | 4JNE | 4B9Q |
|---|---|---|
| Title | Allosteric opening of the polypeptide-binding site when an Hsp70 binds ATP | Open conformation of ATP-bound Hsp70 homolog DnaK |
| Method | X-ray | X-ray |
| Resolution | 1.96 Å | 2.4 Å |
| Rwork / Rfree | 0.173 / 0.201 | 0.196 / 0.239 |
| Protein chains | 2 (A, B) | 4 (A, B, C, D) |
| Ligands | ATP, Mg²⁺ (plus sulfate, glycerol) | ATP, Mg²⁺ |

You will superimpose all **6 chains** on chain A of 4JNE and ask how similar the chains are, both within one crystal and between the two crystals.

## Learning goals

- Fetch structures directly from the PDB in ChimeraX.
- Split a multi-chain model so chains can be superimposed independently.
- Align chains with `matchmaker` and read the reported RMSD and number of matched residues.
- Colour by B-factor and relate it to local structural variability.

The root mean square deviation over $N$ matched atom pairs is

$$ rmsd = \sqrt{\frac{1}{N}\sum_{i=1}^{N}R_{i}^{2}} $$

where $R_i$ is the distance between the $i$-th pair of atoms after superposition.

## Step 1: Open the structures

> <i class="fas fa-pencil-alt"></i> **Hands-on: Fetch the structures**
>
> No download is needed. ChimeraX fetches the entries from the PDB. Type in the command line:
>
> ```
> close session
> open 4jne
> open 4b9q
> ```
>
> `4jne` becomes model `#1` and `4b9q` becomes model `#2`.
>
> Check what was loaded:
>
> ```
> info models
> info chains
> ```

> <i class="fas fa-question"></i> **Question**
>
> How many chains does each model contain?

- [( )] 4JNE: 1 chain, 4B9Q: 2 chains
- [(X)] 4JNE: 2 chains (A, B), 4B9Q: 4 chains (A, B, C, D)
- [( )] 4JNE: 4 chains, 4B9Q: 2 chains

## Step 2: Split the models into chains

`matchmaker` moves a whole model. If chain A and chain B are in the same model, aligning B onto A would move both together and nothing would change. So first split each model into one submodel per chain.

> <i class="fas fa-pencil-alt"></i> **Hands-on: Split the chains**
>
> ```
> split #1
> split #2
> info models
> ```
>
> You should now have `#1.1` and `#1.2` (4JNE chains A and B) and `#2.1` to `#2.4` (4B9Q chains A to D). Check the numbering in the *Model Panel* or in the `info models` output before continuing.

Optional: give each chain its own colour and show only the cartoon.

```
hide atoms
cartoon
color #1.1 steelblue target c
color #1.2 lightskyblue target c
color #2.1 orange target c
color #2.2 gold target c
color #2.3 tomato target c
color #2.4 salmon target c
view
```

## Step 3: Superimpose all chains on chain A of 4JNE

> <i class="fas fa-pencil-alt"></i> **Hands-on: Run matchmaker**
>
> Align every other chain to chain A of 4JNE (`#1.1`):
>
> ```
> matchmaker #1.2#2.1-4 to #1.1
> ```
>
> ChimeraX aligns the sequences first, then fits the matched residues. For each chain it prints one line in the *Log* with:
>
> - the **RMSD** between the pruned atom pairs (outliers removed during the fit)
> - the **number of matched pairs** in that fit
> - the RMSD **across all pairs**, with the number of pairs
>
> Write the results into a table like this one:
>
> | Chain moved | RMSD, pruned pairs (Å) | Pairs (pruned) | RMSD, all pairs (Å) | Pairs (all) |
> |---|---|---|---|---|
> | 4JNE B (`#1.2`) | | | | |
> | 4B9Q A (`#2.1`) | | | | |
> | 4B9Q B (`#2.2`) | | | | |
> | 4B9Q C (`#2.3`) | | | | |
> | 4B9Q D (`#2.4`) | | | | |

Useful variations:

```
# also show the sequence alignment that matchmaker used for the pairing
matchmaker #1.2#2.1-4 to #1.1 showAlignment true

# repeat one chain and print the rotation matrix as well
matchmaker #2.1 to #1.1 reportMatrix true
```

> **Note:** `matchmaker` fits the C-alpha backbone of the residues it pairs by sequence. Two models in one command are written without a comma between them (`#1.2#2.1-4`). A comma means several submodels or residues of the *same* level, as in `#2.1-4` or `#1.1,2`.

> <i class="fas fa-question"></i> **Questions**
>
> 1. Which pair of chains from *the same crystal* has the lowest RMSD? Is this expected?
> 2. Are the RMSD values between the two crystals larger or smaller than within a crystal?
> 3. Does the number of matched residues differ between chains? Look at the first and last residues of each construct and at the unmodelled residues.


## Step 4: Check domains separately

DnaK has two domains: the nucleotide-binding domain (NBD, about residues 1 to 388) and the substrate-binding domain (SBD, about residues 389 to 607). A large global RMSD can mean either that both domains differ or that they only moved relative to each other. Fit the NBD alone and then compare:

```
matchmaker #1.2#2.1-4 to #1.1
matchmaker #1.2:1-388#2.1-4:1-388 to #1.1:1-388
```

> **Note:** residue numbering can differ slightly between entries near the C-terminus. If you restrict to the SBD, check the numbering of both models first (for example with `info residues #1.1:600-610` and `info residues #2.1:600-610`).

> <i class="fas fa-question"></i> **Question**
>
> Is the RMSD lower when you fit only the NBD? What does that tell you about the relative position of the SBD?

## Step 5: Colour by B-factor

> <i class="fas fa-pencil-alt"></i> **Hands-on: Colour by B-factor**
>
> ```
> show #1,2 cartoon
> color bfactor #1 palette bluered
> color bfactor #2 palette bluered
> ```
>
> Blue is low B-factor (well ordered) and red is high B-factor (mobile or poorly defined). Colouring each model separately scales the palette to that model's own B-factor range. This matters because 4JNE (1.96 Å) and 4B9Q (2.4 Å) were refined differently, so absolute B-factor values should not be compared across entries.
>
> You can also use the Menu: `Actions > Color > By Attribute`, or the *Molecule Display* tools.

A second view, where thick tubes mean high B-factor:

```
worm bfactor #1,2
```

Switch back to the normal cartoon with `~worm #1,2`.

To compare the B-factors with the local variability, show the superimposed chains again and look at where they drift apart:

```
show #1,2 models
matchmaker #1.2#2.1-4 to #1.1
```

> <i class="fas fa-question"></i> **Questions**
>
> 1. Where in the structure are the B-factors highest (NBD, SBD β-sandwich, lid helices, loops, termini)?
> 2. Are the regions with high B-factors also the ones where the superimposed chains differ most?
> 3. Do the four chains of 4B9Q differ more from each other than the two chains of 4JNE? Why could a crystal with more copies in the asymmetric unit show more variation?
> 4. Which of the two structures would you use for atomic-level analysis of the ATP site, and why? (Consider resolution, Rfree and PDB-REDO or validation results.)


## Summary

- `split` separates chains of one model so each can be moved on its own.
- `matchmaker #a to #b` aligns by sequence and then by structure and reports RMSD and number of matched pairs.
- Pruned-pair RMSD describes the well-fitting core. All-pair RMSD includes flexible parts.
- B-factors and structural differences between copies both point to flexible regions, but neither alone proves flexibility. Resolution and crystal packing matter as well.

## Reference: all commands in one place

```
close session
open 4jne
open 4b9q
split #1
split #2
info models

hide atoms
cartoon
matchmaker #1.2#2.1-4 to #1.1

color bfactor #1 palette bluered
color bfactor #2 palette bluered
worm bfactor #1,2
```
