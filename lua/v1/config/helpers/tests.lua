Tests = {}
Tests.__index = Tests
function Tests:summary_toggle()
  return function()
    require("neotest").summary.toggle()
  end
end

function Tests:run_suite()
  return function()
    require("neotest").run.run("tests")
  end
end

function Tests:run_nearest()
  return function()
    require("neotest").run.run()
  end
end

function Tests:run_file()
  return function()
    require("neotest").run.run(vim.fn.expand("%"))
  end
end

function Tests:run_last()
  return function()
    require("neotest").output_panel.clear()
    require("neotest").run.run_last()
  end
end

function Tests:stop()
  return function()
    require("neotest").run.stop()
  end
end

function Tests:attach()
  return function()
    require("neotest").run.attach()
  end
end

function Tests:open_output()
  return function()
    require("neotest").output.open({ enter = true })
  end
end

function Tests:toggle_output_panel()
  return function()
    require("neotest").output_panel.toggle()
  end
end
