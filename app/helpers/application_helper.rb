module ApplicationHelper
  def split_think_value(value)
    s_val = value.to_s

    think_open_tag = "<think>"
    think_close_tag = "</think>"

    start_open_tag_idx = s_val.index(think_open_tag)

    # Check if <think> tag exists
    return [nil, s_val] if start_open_tag_idx.nil?

    idx_after_open_tag = start_open_tag_idx + think_open_tag.length

    start_close_tag_idx = s_val.index(think_close_tag, idx_after_open_tag)

    # Check if </think> tag exists after <think>
    return [nil, s_val] if start_close_tag_idx.nil?

    # Extract think_content: content between <think> and </think>
    # The problem implies <think> is at the beginning. If it can be anywhere,
    # this logic holds, but the "result" is then everything after the *first* </think>.
    think_content = s_val[idx_after_open_tag...start_close_tag_idx].strip

    idx_after_close_tag = start_close_tag_idx + think_close_tag.length
    result = s_val[idx_after_close_tag..].strip

    [think_content, result]
  end
end
