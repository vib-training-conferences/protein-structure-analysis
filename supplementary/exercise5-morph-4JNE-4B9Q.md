<!--
author:   Alexander Botzki
email:    alexander.botzki@vib.be
version:  1.0.0
language: en
narrator: US English Female
link:     https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css

comment:  Morph chain A of 4JNE into chain A of 4B9Q in ChimeraX and record a movie.
-->

# Exercise 5: Morph chain A of 4JNE and 4B9Q

A morph is an animation that interpolates the atom positions between two conformations. It does not show a real pathway, but it is a quick way to see **where** and **how much** two structures differ.

Here you morph chain A of 4JNE (`#1.1`) into chain A of 4B9Q (`#2.1`), both ATP-bound DnaK. This exercise continues from [Exercise 4](exercise4-compare-4JNE-4B9Q.md), where the two entries were opened and split into one model per chain.

## Step 1: Prepare the two chains

> <i class="fas fa-pencil-alt"></i> **Hands-on: Open, split and superimpose**
>
> Skip the first four lines if the models from Exercise 4 are still open.
>
> ```
> close session
> open 4jne
> open 4b9q
> split #1
> split #2
> matchmaker #2.1 to #1.1
> ```
>
> Check the numbering with `info models`. You need chain A of 4JNE as `#1.1` and chain A of 4B9Q as `#2.1`.
>
> Superimposing first matters: the morph interpolates the atom coordinates, so unfitted chains would simply slide through space instead of showing the real conformational difference.

## Step 2: Create the morph

> <i class="fas fa-pencil-alt"></i> **Hands-on: Morph**
>
> ```
> morph #1.1#2.1
> light simple
> ```
>
> - `morph #1.1#2.1` creates a new model, `#3`, that holds the animation. It starts in the first structure (`#1.1`, 4JNE) and ends in the second (`#2.1`, 4B9Q). The default is 50 intermediate steps, which gives 51 coordinate sets.
> - To morph in the opposite direction, swap the order: `morph #2.1#1.1`.
> - `light simple` switches to simple lighting. It is faster to render and avoids shadows flickering during the animation.
>
> To keep the view clear, hide the original structures so only the morph shows:
>
> ```
> hide #1,2 models
> view
> ```

> **Note:** the two chains are not identical in length (4JNE chain A has 600 modelled residues, 4B9Q chain A about 600 but with a slightly different range). In a test with ChimeraX 1.12, `morph #1.1#2.1` still produced a 51-frame morph for these two chains. Two models are written without a comma (`#1.1#2.1`); a comma would mean submodels of the same parent.

## Step 3: Play the morph

> <i class="fas fa-pencil-alt"></i> **Hands-on: Play it back and forth**
>
> ```
> coordset #3 1,51 bounce true loop 3
> ```
>
> - `coordset #3 1,51` plays coordinate sets 1 to 51 of model `#3`.
> - `bounce true` plays forwards and then backwards instead of jumping back to the start.
> - `loop 3` repeats the animation three times.
>
> To step through it by hand, open a slider with `coordset slider #3`.

Colour the morph by B-factor or by chain to make the moving parts easier to see:

```
color #3 bychain
color bfactor #3 palette bluered
```

> <i class="fas fa-question"></i> **Questions**
>
> 1. Which parts of chain A move most: the nucleotide-binding domain, the substrate-binding domain, the lid, or the linker between them?
> 2. Do the regions that move most coincide with those that have high B-factors?
> 3. The morph is a straight-line interpolation. Why can it not be read as the real path of the conformational change?

## Step 4: Record a movie

> <i class="fas fa-pencil-alt"></i> **Hands-on: Record the animation**
>
> Put the whole recording on one line so the commands run in order:
>
> ```
> movie record ; coordset #3 1,51 bounce true loop 3 ; wait 310 ; movie encode morph3.mp4
> ```
>
> - `movie record` starts capturing frames.
> - The `coordset` command plays the animation. One bounce forwards and back is about 100 frames, so 3 loops are about 300 frames.
> - `wait 310` pauses the command list until enough frames have been captured. Without it the movie would be encoded before the animation has played. If your movie is cut short, increase this number.
> - `movie encode morph3.mp4` stops the recording and writes the video file. By default it is saved in your current working directory (ChimeraX's home folder or the folder you opened from). Use a full path to choose another location.

Adjust the view before you record, because the camera is fixed once the recording starts:

```
view
turn y 20
```

## Reference: all commands in one place

```
close session
open 4jne
open 4b9q
split #1
split #2
matchmaker #2.1 to #1.1

morph #1.1#2.1
light simple
hide #1,2 models
view

coordset #3 1,51 bounce true loop 3

movie record ; coordset #3 1,51 bounce true loop 3 ; wait 310 ; movie encode morph3.mp4
```
