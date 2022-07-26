# Contributing

```bash
git clone git@gitlab.tingtt.jp:root/slidev.git
```

```bash
cd slidev
make branch BRANCH=branch_name
```

```bash
code --install-extension antfu.slidev
```

```bash
yarn
yarn dev
```

```bash
# Update slide
vim slides.md

git add slides.md
git commit -m '...'
```

```bash
make tag TAG=v1.0.0

git push origin head
```