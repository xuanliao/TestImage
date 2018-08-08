# encoding: utf-8
#
# This file is a part of Redmin CMS (redmine_cms) plugin,
# CMS plugin for redmine
#
# Copyright (C) 2011-2018 RedmineUP
# http://www.redmineup.com/
#
# redmine_cms is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_cms is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_cms.  If not, see <http://www.gnu.org/licenses/>.

require File.expand_path('../../test_helper', __FILE__)

class RedmineCms::CommonViewsTest < ActiveRecord::VERSION::MAJOR >= 4 ? Redmine::ApiTest::Base : ActionController::IntegrationTest
  fixtures :projects, :users

  RedmineCMS::TestCase.create_fixtures([:cms_layouts, :cms_snippets, :cms_pages, :cms_parts,
                                        :cms_page_fields, :cms_menus, :cms_content_versions])

  def setup
    CmsPage.rebuild_tree!
    @page = CmsPage.find(1)
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new    
    @request.env['HTTP_REFERER'] = 'http://test.host/issues/show/1'
    @request.env['REMOTE_ADDR'] = '127.0.0.1'
  end

  def test_index_pages
    log_user("admin", "admin")
    get "/cms/snippets"
    assert_response :success
    get "/cms/settings"
    assert_response :success
    get "/cms/pages"
    assert_response :success
    get "/cms/menus"
    assert_response :success
    get "/cms/layouts"
    assert_response :success
    get "/cms/redmine_layouts"
    assert_response :success
    get "/cms/settings/redmine_hooks"
    assert_response :success
    get "/cms/redirects"
    assert_response :success
    get "/cms/assets"
    assert_response :success
    get "/cms/variables"
    assert_response :success
  end


end
