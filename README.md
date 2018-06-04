# ansible-backup-env
一键部署备份环境

实时备份，在运维工作中属于家常便饭，也是企业运作稳定的保障（数据的冗余非常重要）。我们规划的实时备份体系，是每个节点都监听/backup目录，当用户把备份的内容放入该目录后，则会实时同步到备份服务器上。 建立这套体系，技术选型如下：
- rsync 同步服务，选择守护进程模式；
- sersync 开源的实时同步工具；
- 批量管理工具：ansible；

# 规划
- 用户
rsync uid:801

- 目录
1）/scripts 所有脚本存放的目录；

2）/backup 备份存放的目录，也是实时同步监听的目录；


# 环境准备
1）中控机上安装好Ansible工具；

2）中控机与各服务器之间已建立好SSH的无密码认证；

# ansible目录结构
```
# 最终部署完毕的目录结构
[root@Ansible-host-80 ansible]# tree /etc/ansible/
/etc/ansible/
├── ansible.cfg # 主配置文件
├── hosts # 主机列表文件
├── roles # 暂时没用上
├── tasks #配置任务的地方
│ ├── 01.prepare.yaml
│ ├── 02.backup_server.yaml
├── templates # 模板、配置文件
│ ├── rsyncd.conf
│ ├── rsync.password
│ └── rsync_server.sh
└── tools # 工具包
    └── sersync.running.tar.gz
```

# 部署步骤

1）把ansible目录下载并覆盖到中控机的/etc/ansible；

2）修改 /etc/ansbile/hosts 的主机列表，根据实际情况修改IP；

3）运行ansbile命令；
```
ansible-playbook /etc/ansible/tasks/01.prepare.yaml -f 2
ansible-playbook /etc/ansible/tasks/02.backup_server.yaml -f 2
```
# 部署成功的效果
在节点（172.16.1.31）上的/backup/目录下创建文件，检查该文件是否在备份服务器（172.16.1.41）的/backup下能找到。