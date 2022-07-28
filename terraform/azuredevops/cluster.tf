data "databricks_node_type" "smallest" {
  depends_on = [azurerm_databricks_workspace.this]

  local_disk = true
}

data "databricks_spark_version" "latest_lts" {
  depends_on = [azurerm_databricks_workspace.this]

  long_term_support = true
}

resource "databricks_cluster" "nutter_demo" {
  depends_on = [azurerm_databricks_workspace.this]
  
  cluster_name            = "Nutter demo (${data.databricks_current_user.me.alphanumeric})"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  spark_conf = {
    # Single-node
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }

  library {
    pypi {
      package = "nutter"
    }
  }
  library {
    pypi {
      package = "chispa"
    }
  }

}
