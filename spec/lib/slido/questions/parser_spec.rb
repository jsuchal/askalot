require 'spec_helper'

describe Slido::Questions::Parser do
  subject { described_class }

  it 'parses questions' do
    data = fixture('slido/questions.json').read

    questions = subject.parse(data)

    expect(questions.size).to eql(7)

    question = questions.first

<<<<<<< HEAD
    expect(question.title).to             eql('What is the purpose of Life?')
    expect(question.text).to              eql('What is the purpose of Life?')
    expect(question.slido_event_uuid).to  eql(1257)
    expect(question.slido_uuid).to        eql(15807)
=======
    expect(question.title).to eql('What is the purpose of Life?')
    expect(question.text).to  eql('What is the purpose of Life?')
>>>>>>> Add Slido questions parser
  end
end
