### aérer un .dot

https://stackoverflow.com/questions/17150667/more-compact-hierarchical-layout-for-dot-graphviz

```bash
unflatten -f -l 2 connect2.dot | dot -Gsize="16.52,11.68" -Gratio="fill"  -Glandscape=false -Gsplines=ortho -Tpdf -o graph.gv.pdf
```
