load('ext://helm_remote', 'helm_remote')
helm_remote('localstack', repo_name='localstack-charts')

docker_build('coinbase-monitor', '.')
k8s_yaml('k8s.yaml')
k8s_resource('coinbase-monitor', port_forwards=8080)
