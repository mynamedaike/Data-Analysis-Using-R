Homework 09: Building your own R package
================
Ke Dai
2016年12月4日

Introduction to my package
--------------------------

I built a package called string. This package is complementary to stringr package. It includes three functions: `string_insert`, `string_cut` and `string_replace`. `string_insert` inserts a string to another string at a given position. `string_cut` cuts a substring between two given positions from a string. `string_replace` replaces a substring between two given positions in a string with another string. The API and source code of this tiny package is [here](https://github.com/mynamedaike/string).

My reflections
--------------

It's interesting to build my own R package. I learned a lot from this homework. The process was going on smoothly. I did not encounter any tricky problems. Due to time constraint, I only developed three functions for this package. The functionality of this package is limited. All of three functions can only apply to a single string not a character list or vector. I will extend and refine this package in the future.

Some useful links
-----------------

-   [Write your own R package, Part One](http://stat545.com/packages04_foofactors-package-01.html)
-   [Write your own R package, Part Two](http://stat545.com/packages05_foofactors-package-02.html)
