require 'spec_helper'
require 'bh/helpers/button_group_helper'
include Bh::ButtonGroupHelper

describe 'button_group' do
  specify 'given a block it renders its default classes' do
    expect(button_group &Proc.new {}).to eq '<div class="btn-group "></div>'
  end

  specify 'given a block it renders it captures the blocks output' do
    expect(button_group &Proc.new { 'Test output' }).to eq '<div class="btn-group ">Test output</div>'
  end

  specify 'given a block and size options it renders with size class' do
    expect(button_group size: :large, &Proc.new {}).to eq '<div class="btn-group btn-group-lg"></div>'
  end

  specify 'given a block and toolbar option it renders with toolbar class' do
    expect(button_group toolbar: true, &Proc.new {}).to eq '<div class="btn-toolbar "></div>'
  end

  specify 'given a block and direction option it renders direction class' do
    expect(button_group(dropup: true, &Proc.new {})).to eq '<div class="btn-group  dropup"></div>'
  end

  specify 'given a block and layout option it renders with justfied classes' do
    expect(button_group(layout: :justified, &Proc.new {})).to eq '<div class="btn-group btn-group-justified "></div>'
  end

  specify 'given a block and layout option it renders with vertical classes' do
    expect(button_group(layout: :vertical, &Proc.new {})).to eq '<div class="btn-group-vertical "></div>'
  end
end

describe 'button' do 
  specify 'given a name it renders its name and default classes' do
    expect(button('Button')).to eq '<button class="btn btn-default ">Button</button>'
  end

  specify 'given a name and context options it renders with context' do
    expect(button('Button', context: :info)).to eq '<button class="btn btn-info ">Button</button>'
  end

  specify 'given a name and size options it renders with size' do
    expect(button('Button', size: :large)).to eq '<button class="btn btn-default btn-lg">Button</button>'
  end

  specify 'given a block and split option it renders splitted button' do
    expect(button('Button', split: true, &Proc.new { 'Dropdown content' })).to eq '<button class="btn btn-default ">Button</button><button class="btn btn-default  dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>Dropdown content'
  end

  specify 'given a block option it renders button with caret and dropdown content' do
    expect(button('Button', &Proc.new { 'Dropdown content' })).to eq '<button class="btn btn-default  dropdown-toggle" data-toggle="dropdown">Button <span class="caret"></span></button>Dropdown content'
  end

  specify 'given a block it renders a space between button name and caret element' do
    content = button_group do 
      button 'Button label', context: :info, &Proc.new {}
    end
    expect(content).to include 'Button label <span class="caret"'
  end
end
