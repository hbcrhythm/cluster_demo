cd ..\_build\default\lib\cluster\ebin
start werl -hidden -kernel inet_dist_listen_min 40001 inet_dist_listen_max 40100 +P 102400 +Q 100000 +K true +d -smp enable +sub true -name cluster_auth_1@127.0.0.1 -setcookie qetss -s cluster start -pa ../../cluster/ebin ../../lager/ebin ../../goldrush/ebin ../../demo/ebin -config ../../../../../config/auth.config
exit