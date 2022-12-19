# Gitlab Runner 

| Documentations                                                                          | Description                                                               |
|-----------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| [Gitlab Runner Helm Chart](https://docs.gitlab.com/runner/install/kubernetes.html)      | Guide & documentation for chart of the kubernetes gitlab runner executor. |
| [values.yaml](https://gitlab.com/gitlab-org/charts/gitlab-runner/blob/main/values.yaml) | Helm values file.                                                         |

## Install a gitlab runner

```shell
RUNNER_NAME=<YOUR VALUE HERE>
RUNNER_NAMESPACE=<YOUR VALUE HERE>
RUNNER_REGISTRATION_TOKEN=<YOUR VALUE HERE>
RUNNER_TAGS=<COMMA SEPARATED LIST OF TAGS>

GITLAB_URL=<YOUR VALUE HERE>

helm repo add gitlab https://charts.gitlab.io
helm install\
  --namespace $RUNNER_NAMESPACE\
  --set gitlabUrl=$GITLAB_URL\
  --set runnerRegistrationToken=$RUNNER_REGISTRATION_TOKEN\
  --set tags=$RUNNER_TAGS
  $RUNNER_NAME\
  gitlab/gitlab-runner
```