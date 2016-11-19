## Prerequisites
You should have installed the make and makefile2graph.

## Steps
To Run the data anlaysis pipeline, you should take the following steps:

Step 0: clone or download this folder to your local machine, open the shell or the command line window, and then enter the root directory of this folder

Step 1: clear all the tsv, csv, png, html files and report.md using the following command:

```
make clean
```

Step 2: automate the pipline using the following command:

```
make
```

Step 3: generate the graphical view of the pipeline using the following command:

```
make -Bnd | make2graph | dot -Tpng -o graphical-view-of-my-pipeline.png
```
