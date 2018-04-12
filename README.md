# 484FinalProj

## Directions
`git clone [repo name]` to clone the repository into your current working directory

`git pull` to get all changes from master and get your local repo up to date

`git add [file]` to add a file to commit

`git commit -m 'message'` to commit your changes and add a message

`git push` to push all your commits to master

Always start your programming session by running `git pull` to avoid merge conflicts.  You want to always be working with very up to date information.
If you run into a merge conflict:
* Go to the conflicted file, and there should be overlay of your edits and master's edits
* Clean up the changes, lots of code will be duplicated, so ensure to delete all unnecessary code
* Push the resolved conflict

Make sure to commit early, commit often.  Also, if you feel like it, feel free to `branch` your repo and work on a separate branch until you are confident that you're code is correct.

More information on markdown (md) which is what this readme is written on here: [md cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

## Create a subfile
To create a subfile, say sub.tex, use the header:
```
\documentclass[../main.tex]{subfiles}

\begin{document}
```
and footer:
```
\end{document}
```
around your sub.tex subfile.

## Adding subfiles to the report
To add a subfile to a latex file:
```
\subfile{<relative or absolute path of sub.tex>}
```

## Compilation and Running
To compile and run the fortran bezier surface code, type:
```
cd 484FinalProj
make
./main_exe
```
Then, open `main.m` on Matlab graph the surface.

## Description of All Files

### main.f90 and bezier.f90
`main.f90` calls `bezier.f90` (a module) to create a bezier surface provided the `controlPoints.txt` file (described below).  It will interpolate the 100x100 interior points having defined the 16 control points.  The result is written to `bezierPoints.dat` which the matlab code `main.m` can read to graph, and work with. 

### Control Points File
The control points file allows the user to write 16 control points, and the Bezier.f90 file will use a bezier surface interpolation scheme to interpolate all the points that exist between the control points.  To appropriately write a control point file, follow the following guideline:

```
| 1 | 5 | 9  | 13 |
| 2 | 6 | 10 | 14 |
| 3 | 7 | 11 | 15 |
| 4 | 8 | 12 | 16 |
```

In which each number corresponds to the line number, and its location indicates what part of the surface it toggles.

### main.m
Currently, the matlab script will open `bezierPoints.dat` and graph the surface that was interpolated using the 16 control points in `controlPoints.txt`
