# julia-repology-visualization

Looking at which licenses are the most popular using data taken from repology.org.


## generating `package.json`

``` sh
curl -L 'https://repology.org/api/v1/projects/?repos=5-&newest=True' > packages.json
```

## references
* [repology api](https://repology.org/api)
