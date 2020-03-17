#
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package templates.gcp.GCPBigQueryDatasetWorldReadableConstraintV1

import data.validator.gcp.lib as lib

deny[{
	"msg": message,
	"details": metadata,
}] {
	constraint := input.constraint
	asset := input.asset
	asset.asset_type == "bigquery.googleapis.com/Dataset"

	world_readable_checks := [
		asset.iam_policy.bindings[_].members[_] == "allUsers",
		asset.iam_policy.bindings[_].members[_] == "allAuthenticatedUsers",
	]

	world_readable_checks[_] == true

	ancestry_path = lib.get_default(asset, "ancestry_path", "")
	message := sprintf("%v is publicly accessable", [asset.name])
	metadata := {"resource": asset.name, "ancestry_path": ancestry_path}
}
