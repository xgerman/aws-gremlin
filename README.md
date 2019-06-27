AWS Gremlin

Playing with Gremlin we ran into the problem that Gremlin would use the local
ECS docker ip as identifier. In our network setup this was the public (LB) IP
shared between all our instances. Hence gremlin would not properly show up
on the Gremin console.

This adds a line to the entryfile to assign the local IP obtained from
AWS Metadata Service as the identifier.

Manual: `sudo docker run -d --net=host     --cap-add=NET_ADMIN --cap-add=SYS_BOOT --cap-add=SYS_TIME     --cap-add=KILL     -v $PWD/var/lib/gremlin:/var/lib/gremlin     -v $PWD/var/log/gremlin:/var/log/gremlin     -e GREMLIN_TEAM_ID="$GREMLIN_TEAM_ID"     -e GREMLIN_TEAM_SECRET="$GREMLIN_TEAM_SECRET"  -it  xgerman/gremlin`

Otherwise use the sample from https://www.gremlin.com/community/tutorials/how-to-install-gremlin-on-ecs/ and replace the image with `xgerman/gremlin`

