require 'spec_helper'

describe Huia do
  it { should respond_to :eval }
  it { should respond_to :load }
end
