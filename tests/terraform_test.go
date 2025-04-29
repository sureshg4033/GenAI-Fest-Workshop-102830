package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// TestTerraformBootstrap tests the bootstrap module
func TestTerraformBootstrap(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../bootstrap",
		NoColor:      true,
	})

	// Run terraform init and terraform plan
	terraform.Init(t, terraformOptions)
	planOutput := terraform.Plan(t, terraformOptions)
	
	// Verify the plan output contains expected resources
	assert.Contains(t, planOutput, "aws_s3_bucket.terraform_state")
	assert.Contains(t, planOutput, "aws_dynamodb_table.terraform_locks")
}

// TestTerraformDevEnvironment tests the dev environment configuration
func TestTerraformDevEnvironment(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../environments/dev",
		NoColor:      true,
	})

	// Run terraform init and terraform plan
	terraform.Init(t, terraformOptions)
	planOutput := terraform.Plan(t, terraformOptions)
	
	// Verify the plan output contains expected resources
	assert.Contains(t, planOutput, "module.networking")
	assert.Contains(t, planOutput, "module.compute")
}

// TestTerraformStagingEnvironment tests the staging environment configuration
func TestTerraformStagingEnvironment(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../environments/staging",
		NoColor:      true,
	})

	// Run terraform init and terraform plan
	terraform.Init(t, terraformOptions)
	planOutput := terraform.Plan(t, terraformOptions)
	
	// Verify the plan output contains expected resources
	assert.Contains(t, planOutput, "module.networking")
	assert.Contains(t, planOutput, "module.compute")
}

// TestNetworkingModule tests the networking module
func TestNetworkingModule(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../modules/networking",
		NoColor:      true,
	})

	// Validate the module
	terraform.InitAndValidate(t, terraformOptions)
}

// TestComputeModule tests the compute module
func TestComputeModule(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../modules/compute",
		NoColor:      true,
	})

	// Validate the module
	terraform.InitAndValidate(t, terraformOptions)
}

// TestStateModule tests the state module
func TestStateModule(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../modules/state",
		NoColor:      true,
	})

	// Validate the module
	terraform.InitAndValidate(t, terraformOptions)
}