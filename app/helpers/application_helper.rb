module ApplicationHelper
  def pagination(collection)
    will_paginate collection, renderer: BootstrapPagination::Rails
  end
end
