**Definition**

---
The YAML file (kyverno_cluster_wide_psa_full.yaml) defines two Kyverno `ClusterPolicy` resources aimed at enhancing Pod Security Admission (PSA) within a Kubernetes cluster. Kyverno is a policy engine designed for Kubernetes, which allows you to define, validate, and enforce policies for your Kubernetes resources.

The first `ClusterPolicy` named `add-psa-labels-full` is designed to automatically add specific PSA labels to all newly created namespaces. The labels `pod-security.kubernetes.io/enforce=baseline` and `pod-security.kubernetes.io/warn=restricted` are added if they are not already present. This policy ensures that namespaces adhere to a baseline security profile and issue warnings for restricted profiles, thereby enforcing a consistent security posture across the cluster. The policy uses a `mutate` rule with a `patchStrategicMerge` strategy to add the labels to the namespace metadata.

The second `ClusterPolicy` named `deny-privileged-profile` aims to prevent the creation of namespaces with a `privileged` security profile unless the user has the `cluster-admin` role. This policy is crucial for maintaining cluster security by ensuring that only highly privileged users can create namespaces that allow unrestricted workloads. The policy includes a `validate` rule that checks for the presence of the `pod-security.kubernetes.io/enforce=privileged` label on namespaces. If such a label is found and the user does not have the `cluster-admin` role, the policy denies the creation of the namespace and logs an audit message. This helps in preventing potential circumvention of the cluster's default security settings.

Together, these policies help in automating the enforcement of security standards and controlling the assignment of privileged security profiles, thereby enhancing the overall security of the Kubernetes cluster.


---
The YAML file (kyverno_cluster_wide_psa.yaml)
This`ClusterPolicy` named `add-psa-labels` is designed to automatically add specific PSA labels to all newly created namespaces. The labels `pod-security.kubernetes.io/enforce=baseline` and `pod-security.kubernetes.io/warn=restricted` are added if they are not already present. This policy ensures that namespaces adhere to a baseline security profile and issue warnings for restricted profiles, thereby enforcing a consistent security posture across the cluster. The policy uses a `mutate` rule with a `patchStrategicMerge` strategy to add the labels to the namespace metadata.
