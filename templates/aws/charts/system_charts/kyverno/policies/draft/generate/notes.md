# Generate Resources
# Kyverno has the ability to generate (i.e., create) a new Kubernetes resource based upon a definition stored in a policy.
# Like both validate and mutate rules, Kyverno generate rules use similar concepts and structures to express policy.
# The generation ability is both powerful and flexible with one of its most useful aspects being, in addition to the initial generation, it has the ability to continually synchronize the resources it has generated.
# Generate rules can be a powerful automation tool and can solve many common challenges faced by Kubernetes operators.
# Let’s look at one such use case in this guide.

# We will use a Kyverno generate policy to generate an image pull secret in a new Namespace.

# First, create this Kubernetes Secret in your cluster which will simulate a real image pull secret.

# kubectl -n default create secret docker-registry regcred \
#   --docker-server=myinternalreg.corp.com \
#   --docker-username=john.doe \
#   --docker-password=Passw0rd123! \
#   --docker-email=john.doe@corp.com
# bash
# By default, Kyverno is configured with minimal permissions and does not have access to security sensitive resources like Secrets. You can provide additional permissions using cluster role aggregation. The following role permits the Kyverno background-controller to create (clone) secrets.

# kubectl apply -f- << EOF
# apiVersion: rbac.authorization.k8s.io/v1
# kind: ClusterRole
# metadata:
#   name: kyverno:secrets:view
#   labels:
#     rbac.kyverno.io/aggregate-to-admission-controller: "true"
#     rbac.kyverno.io/aggregate-to-reports-controller: "true"
#     rbac.kyverno.io/aggregate-to-background-controller: "true"
# rules:
# - apiGroups:
#   - ''
#   resources:
#   - secrets
#   verbs:
#   - get
#   - list
#   - watch
# ---
# apiVersion: rbac.authorization.k8s.io/v1
# kind: ClusterRole
# metadata:
#   name: kyverno:secrets:manage
#   labels:
#     rbac.kyverno.io/aggregate-to-background-controller: "true"
# rules:
# - apiGroups:
#   - ''
#   resources:
#   - secrets
#   verbs:
#   - create
#   - update
#   - delete
# EOF
# yaml
# Next, create the following Kyverno policy. The sync-secrets policy will match on any newly-created Namespace and will clone the Secret we just created earlier into that new Namespace.

apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: sync-secrets
spec:
  rules:
  - name: sync-image-pull-secret
    match:
      any:
      - resources:
          kinds:
          - Namespace
    generate:
      apiVersion: v1
      kind: Secret
      name: regcred
      namespace: "{{request.object.metadata.name}}"
      synchronize: true
      clone:
        namespace: default
        name: regcred

# Create a new Namespace to test the policy.

# kubectl create ns mytestns
# bash
# Get the Secrets in this new Namespace and see if regcred is present.

# kubectl -n mytestns get secret
# bash
# You should see that Kyverno has generated the regcred Secret using the source Secret from the default Namespace as the template.
# If you wish, you may also modify the source Secret and watch as Kyverno synchronizes those changes down to wherever it has generated it.

# With a basic understanding of generate policies, clean up by deleting the policy you created above.

# kubectl delete clusterpolicy sync-secrets
# bash
# Congratulations, you’ve just implemented a generation policy in your Kubernetes cluster! For more details on generate policies, see the generate section.
