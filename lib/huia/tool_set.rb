require 'rubinius/bridge'
require 'rubinius/toolset'

module Huia
  ToolSet = Rubinius::ToolSets.create :huia do
    require 'rubinius/compiler'
    require 'rubinius/ast'
  end
end
