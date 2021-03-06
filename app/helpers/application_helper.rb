include ApplicationMixin

require 'uri'

module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction, :flag_version => params[:flag_version],
                   :selected_owner => @selected_owner, :selected_status => @selected_status
  end

  def url_to_bugzilla(bug_id)
    "#{URI.join(bz_options['uri'], bz_options['show_bug_prefix'])}#{bug_id}"
  end

  def link_to_bugzilla(bug_id)
    link_to(bug_id, url_to_bugzilla(bug_id))
  end

  def ids_list(bug_ids)
    return [] if bug_ids.blank?
    bug_ids.is_a?(Array) ? bug_ids : bug_ids.split(" ")
  end

  def link_to_bugzillas(bug_ids)
    bug_id_list = ids_list(bug_ids)
    bug_id_list.collect do |bug_id|
      link_to_bugzilla(bug_id)
    end.join(" ").html_safe
  end

  def list_last_commit(bz)
    depends_on_commits =
      Issue.where(:bug_id => bz.depends_on_ids).includes(:commits).collect { |i| i.commits.to_a }.flatten
    commits = bz.commits.to_a | depends_on_commits
    hash = commits.each_with_object(Hash.new(0)) do |c, inner_hash|
      inner_hash[c.branch] += 1
    end

    # TODO: Cleanup this formatting and double looping...
    string = ""
    hash.each do |k, v|
      string << "#{k}: #{v}\n"
    end

    string
  end

  def available_issue_states
    ["All"].concat(Issue.pluck(:status).compact.uniq.sort)
  end

  def available_issue_assigned_to
    ["All"].concat(Issue.pluck(:assigned_to).compact.uniq.sort_by { |assignee| assignee.downcase })
  end

  def available_filters
    ["None"].concat(Settings.dashboard.filters.collect { |filter| filter.name }).uniq
  end

  def filter_name_to_sqlfilter(name)
    Settings.dashboard.filters.find { |filter| filter.name == name }.try(:sqlfilter)
  end

  #
  # Flag helper procs
  #
  def flag_hash_versions(flag_hash)
    flag_versions_string(get_flag_versions(flag_hash))
  end

  def flag_versions_string(flag_versions)
    flag_versions.join(", ")
  end

  def available_flag_versions
    ["All"].concat(Issue.select(:flags).uniq.collect { |issue| get_flag_versions(issue.flag_hash) }.flatten).uniq.sort
  end

  def get_flag_versions(flag_hash)
    flag_versions = flag_hash.each.collect { |flag, value| flag if flag.start_with?("cfme-") }.compact
    flag_versions.blank? ? %w(NONE) : flag_versions
  end

  def get_flag_ack(flag_hash, what)
    get_flag_value(flag_hash, "#{what}_ack")
  end

  def get_flag_name(flag_hash, what)
    get_from_flags(flag_hash).fetch_path(what.to_sym, :name) || "NONE"
  end

  def get_flag_value(flag_hash, what)
    get_from_flags(flag_hash).fetch_path(what.to_sym, :value) || "+"
  end

  def get_from_flags(flag_hash)
    res = {}
    flag_hash.each do |flag, value|
      if flag.start_with?("cfme-")
        res[:version] = {:name => flag, :value => value}
      else
        res[flag.to_sym] = {:name => flag, :value => value}
      end
    end
    res
  end
end
