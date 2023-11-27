function cluster =set_cluster(clustername)
    if strcmpi(clustername,'gadi'),
        disp('--cluster gadi---------------');
        cluster=gadi('np',48);
        cluster.mem=190;
        cluster.time=60*40;
        cluster.project='bi77';
        cluster.queue='normal';
    else
        cluster=generic('name',oshostname(),'np',6);
    end
