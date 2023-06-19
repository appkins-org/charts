project = "HomeLab"
app "HomeLab" {
  build {
    use "files" {
    }
    registry {
      use "files" {
        path = "."
      }
    }
  }
  deploy {
    use "helm" {
      //The following field was skipped during file generation
      chart = ""
      //The following field was skipped during file generation
      name = ""
      //The following field was skipped during file generation
      set = ""
    }
  }
  release {
    use "kubernetes" {
    }
  }
}
