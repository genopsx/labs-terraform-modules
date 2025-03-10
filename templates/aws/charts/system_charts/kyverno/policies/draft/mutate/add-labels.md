# Mutation is the ability to change or “mutate” a resource in some way prior to it being admitted into the cluster.
# A mutate rule is similar to a validate rule in that it selects some type of resource (like Pods or ConfigMaps)
# and defines what the desired state should look like.
# Add this Kyverno mutate policy to your cluster.
# This policy will add the label team to any new Pod and give it the value of bravo but only if a Pod does not already have this label assigned.
# Kyverno has the ability to perform basic “if-then” logical decisions in a very easy way making policies trivial to write and read.
# The +(team) notation uses a Kyverno anchor to define the behavior Kyverno should take if the label key is not found.

apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-labels
spec:
  rules:
  - name: add-team
    match:
      any:
      - resources:
          kinds:
          - Pod
    mutate:
      patchStrategicMerge:
        metadata:
          labels:
            +(team): bravo

# Let’s now create a new Pod which does not have the desired label defined.

# kubectl run redis --image redis
# bash
# Note
# Kyverno may be configured to exclude system Namespaces like kube-system and kyverno. Make sure you create the Pod in a user-defined Namespace or the default Namespace (for testing only).
# Once the Pod has been created, get the Pod to see if the team label was added.

# kubectl get pod redis --show-labels
# bash
# You should see that the label team=bravo has been added by Kyverno.

# Try one more Pod, this time one which does already define the team label.

# kubectl run newredis --image redis -l team=alpha
# bash
# Get this Pod back and check once again for labels.

# kubectl get pod newredis --show-labels
# bash
# This time, you should see Kyverno did not add the team label with the value defined in the policy since one was already found on the Pod.

# Now that you’ve experienced mutate policies and seen how logic can be written easily, clean up by deleting the policy you created above.

# kubectl delete clusterpolicy add-labels
# bash
# Congratulations, you’ve just implemented a mutation policy in your Kubernetes cluster! For more details on mutate policies, see the mutate section.
