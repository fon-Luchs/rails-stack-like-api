class ModelLoader
  def initialize(models = [], params = {})
    @models = models
    @params = params
  end

  def load_rateable
    klass = models.detect { |c| params["#{c.name.underscope}_id"] }
    rateable = klass.find(params["#{c.name.underscope}_id"])
    rateable
  end
end