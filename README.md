# PostgreSQL Tuple Freezing Demo

Live demo [here](https://tuple-freezing-demo.angusd.com/)

A simple demo that simulates Transaction ID (XID) use how `autovacuum` freezes tuples.

It's not meant to be a perfect representation, but an approximation.

If you enable `Simulate XID Exhaustion`, `autocavuum` will stop and you will see what happens when a database is about to run out of Transaction IDs.
