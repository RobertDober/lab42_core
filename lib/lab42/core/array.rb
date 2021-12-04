class Array
  def flatten_once
    inject [] do | r, a |
      case a
      when Array
        [*r] + [*a]
      else
        [*r] + [a]
      end
    end
  end
end # class Array
# SPDX-License-Identifier: Apache-2.0
