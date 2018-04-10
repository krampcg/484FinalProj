# 484FinalProj

## Directions
`git clone [repo name]` to clone the repository into your current working directory

`git pull` to get all changes from master and get your local repo up to date

`git add [file]` to add a file to commit

`git commit -m 'message'` to commit your changes and add a message

`git push` to push all your commits to master

## Control Points File
The control points file allows the user to write 16 control points, and the Bezier.f90 file will use a bezier surface interpolation scheme to interpolate all the points that exist between the control points.  To appropriately write a control point file, follow the following guideline:

```
| 1 | 5 | 9  | 13 |
| 2 | 6 | 10 | 14 |
| 3 | 7 | 11 | 15 |
| 4 | 8 | 12 | 16 |
```

In which each number corresponds to the line number, and its location indicates what part of the surface it toggles.
