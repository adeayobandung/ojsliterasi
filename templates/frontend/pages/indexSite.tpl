{**
 * templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site index.
 *
 *}
{include file="frontend/components/headersite.tpl"}

<div id="main-site" class="page_index_site">

	{if $about}
		<div class="jumbotron" id="site-description">
			{$about|nl2br}
		</div>
	{/if}

	<div class="journals">
		{if !count($journals)}
			<div class="no_journals">
				{translate key="site.noJournals"}
			</div>

		{else}
		<div class="row">
			{iterate from=journals item=journal}
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					{capture assign="url"}{url journal=$journal->getPath()}{/capture}
					{assign var="thumb" value=$journal->getLocalizedSetting('journalThumbnail')}
					{assign var="description" value=$journal->getLocalizedDescription()}

					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">{$journal->getLocalizedName()}</h3>
						</div>
						<div class="panel-body">
							{assign var="displayJournalThumbnail" value=$journal->getLocalizedSetting('homepageImage')}
							{if $displayJournalThumbnail}
								<div class="row">
								<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12"></div>
								<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 homecover">
									<img class="image-responsive" src="{$journalFilesPath}{$journal->getId()}/{$displayJournalThumbnail.uploadName|escape:"url"}" {if $altText != ''}alt="{$altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
								</div>
								</div>
							{/if}
							{$description|nl2br}
						</div>
						<div class="panel-footer">
							<a href="{$url|escape}" class="btn btn-primary btn-sm"><i class="fa fa-desktop"></i> {translate key="site.journalView"}</a>
							<a href="{url|escape journal=$journal->getPath() page="issue" op="current"}"  class="btn btn-info btn-sm"><i class="fa fa-file-text-o"></i> {translate key="site.journalCurrent"}</a>							
						</div>
					</div>
				</div>
			{/iterate}
		</div>

			{if $journals->getPageCount() > 0}
				<div class="cmp_pagination">
					{page_info iterator=$journals}
					{page_links anchor="journals" name="journals" iterator=$journals}
				</div>
			{/if}
		{/if}
	</div>

</div><!-- .page -->

{include file="frontend/components/footersite.tpl"}
