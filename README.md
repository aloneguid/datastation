# DataStation

Portable data engineering / analytics environment.

Includes Polynote, Spark, Scala, Python.

Polynote has Spark 3.2.1 preconfigured already.

To run:

```
docker run -it --rm -p 8192:8192 -p 4040:4040 -v ~/dsd:/opt/notebooks datastation
```

where:
- `8192` is a polynote port.
- `4040` - spark UI.
- `~/dsd` - notebook storage.

