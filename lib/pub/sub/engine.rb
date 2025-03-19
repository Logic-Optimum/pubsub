module Pub
  module Sub
    class Engine < ::Rails::Engine
      isolate_namespace Pub::Sub
    end
  end
end
