AWS Gremlin

Playing with gremlin we ran into the problem that Gremlin would use the local
ECS docker ip as identifier. In our network setup this was the public (LB) IP
shared between all our instances. Hence gremlin would not properly show up
on the Gremin console.

This adds a line to the entryfile to assign the local IP obtained from
AWS Metadat Service as the identifier.

