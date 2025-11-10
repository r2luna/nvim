local test = require("neotest")

Tests = {}
Tests.__index = Tests
function Tests:summary_toggle()
  return function()
    test.summary.toggle()
  end
end

function Tests:run_suite()
  return function()
    test.run.run("tests")
  end
end

function Tests:run_nearest()
  return function()
    test.run.run()
  end
end

function Tests:run_file()
  return function()
    test.run.run(vim.fn.expand("%"))
  end
end

function Tests:run_last()
  return function()
    test.output_panel.clear()
    test.run.run_last()
  end
end

function Tests:stop()
  return function()
    test.run.stop()
  end
end

function Tests:attach()
  return function()
    test.run.attach()
  end
end

function Tests:open_output()
  return function()
    test.output.open({ enter = true })
  end
end

function Tests:toggle_output_panel()
  return function()
    test.output_panel.toggle()
  end
end
