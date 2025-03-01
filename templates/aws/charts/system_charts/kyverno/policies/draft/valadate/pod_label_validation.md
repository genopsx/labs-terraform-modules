# In the validation guide, you will see how simple an example Kyverno policy can be which ensures a label called team is present on every Pod.
# Validation is the most common use case for policy and functions as a “yes” or “no” decision making process.
# Resources which are compliant with the policy are allowed to pass (“yes, this is allowed”) and those which are not compliant may not be allowed to pass (“no, this is not allowed”).
# An additional effect of these validate policies is to produce Policy Reports.
# A Policy Report is a custom Kubernetes resource, produced and managed by Kyverno, which shows the results of policy decisions upon allowed resources in a user-friendly way.
# Add the policy below to your cluster.
# It contains a single validation rule that requires that all Pods have the team label.
# Kyverno supports different rule types to validate, mutate, generate, cleanup, and verify image configurations.
# The field failureAction is set to Enforce to block Pods that are non-compliant. Using the default value Audit will report violations but not block requests.

# Add the policy below to your cluster.
# It contains a single validation rule that requires that all Pods have the team label.
# Kyverno supports different rule types to validate, mutate, generate, cleanup, and verify image configurations.
# The field failureAction is set to Enforce to block Pods that are non-compliant.
# Using the default value Audit will report violations but not block requests.
kubectl create -f- << EOF
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-labels
spec:
  rules:
  - name: check-team
    match:
      any:
      - resources:
          kinds:
          - Pod
    validate:
      failureAction: Enforce
      message: "label 'team' is required"
      pattern:
        metadata:
          labels:
            team: "?*"

# Test the policy by creating a Pod or Deployment without the required label.
# kubectl create deployment nginx --image=nginx


# YOU SHOULD SEE THIS AS OUTPUT:
# error: failed to create deployment: admission webhook "validate.kyverno.svc-fail" denied the request:

# resource Deployment/default/nginx was blocked due to the following policies:

# require-labels:
#   autogen-check-team: 'validation error: label ''team'' is
#     required. Rule autogen-check-team failed at path /spec/template/metadata/labels/team/'


# Note
# Kyverno may be configured to exclude system Namespaces like kube-system and kyverno.
# Make sure you create the Deployment in a user-defined Namespace or the default Namespace (for testing only).
