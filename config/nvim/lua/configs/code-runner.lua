require("code_runner").setup {
  mode = "better_term",
  better_term = { -- Toggle mode replacement
    clean = true, -- Clean terminal before launch
    number = 1, -- Use nil for dynamic number and set init
    init = nil,
  },

  filetype = {
    java = {
      "cd $dir &&",
      "javac $fileName &&",
      "java $fileNameWithoutExt",
    },
    python = "python3 -u",
    typescript = "deno run",
    rust = {
      "cd $dir &&",
      "rustc $fileName &&",
      "$dir/$fileNameWithoutExt",
    },
    elixir = "elixir",
    cpp = {
      "cd build && cmake .. && make && nvidia-offload ./$fileNameWithoutExt; cd ..",
      -- or if your executable name is different from the filename:
      -- "cd build && cmake .. && make && ./your_project_name"
    },

    c = function(...)
      c_base = {
        "cd $dir &&",
        "gcc $fileName -o",
        "/tmp/$fileNameWithoutExt",
      }
      local c_exec = {
        "&& /tmp/$fileNameWithoutExt &&",
        "rm /tmp/$fileNameWithoutExt",
      }
      vim.ui.input({ prompt = "Add more args:" }, function(input)
        c_base[4] = input
        vim.print(vim.tbl_extend("force", c_base, c_exec))
        require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
      end)
    end,
  },

  project = {
    ["~/python/intel_2021_1"] = {
      name = "Intel Course 2021",
      description = "Simple python project",
      file_name = "POO/main.py",
    },
    ["~/deno/example"] = {
      name = "ExapleDeno",
      description = "Project with deno using other command",
      file_name = "http/main.ts",
      command = "deno run --allow-net",
    },
    ["~/cpp/example"] = {
      name = "ExapleCpp",
      description = "Project with make file",
      command = "make buid && cd buid/ && ./compiled_file",
    },
    ["~/private/.*terraform%-prod.-/.-"] = {
      name = "ExampleTerraform",
      description = 'All Folders in ~/private containing "terraform-prod"',
      command = "terraform plan",
    },
  },
}
