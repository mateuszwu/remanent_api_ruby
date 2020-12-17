class ErrorSerializer
  def initialize(model)
    @model = model
  end

  def to_json(*_args)
    errors = model.errors.to_hash
    return if errors.blank?

    { errors: errors }.to_json
  end

  private

  attr_reader :model
end
