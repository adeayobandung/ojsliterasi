{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * UPDATED/CHANGED/MODIFIED: Marc Behiels - marc@elemental.ca - 250416
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div id="main-content" class="page_index_journal" role="content">

	{call_hook name="Templates::Index::journal"}

<ul class="nav nav-pills" id="indexTab">
	<li class="active"><a data-toggle="tab" href="#tab-home"><i class="fa fa-file-text"></i> About Journal</a></li>
	{if $issue}
	<li><a data-toggle="tab" href="#tab-issue"><i class="fa fa-list-alt"></i> Current Issue</a></li>
	{/if}
	<li><a href="{url page="issue" op="archive"}"><i class="fa fa-files-o"></i> Archive</a></li>
	{if $numAnnouncementsHomepage && $announcements|count}
	<li><a data-toggle="tab" href="#tab-announcement"><i class="fa fa-bullhorn"></i> Announcements</a></li>
	{/if}
	{if $additionalHomeContent}
	<li><a data-toggle="tab" href="#tab-otherinfo"><i class="fa fa-file-word-o"></i> Other information</a></li>
	{/if}
</ul>

<div class="tab-content">
	<div id="tab-home" class="tab-pane active">
		<div class="row" id="about-home">
		{if $homepageImage}
			<div class="homepage-image col-md-5 col-lg-5 col-sm-5 col-xs-12">
				<img class="img-responsive" src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
			</div>
		{/if}

		{if $journalDescription}
			<div class="journal-description col-md-7 col-lg-7 col-sm-7 col-xs-12">
				{$journalDescription}
			</div>
		{/if}
		</div>
	</div>

	{* Latest issue *}
	{if $issue}
	<div class="tab-pane" id="tab-issue">
		<section class="current_issue">
			<header class="page-header">
				<h2>
					{translate key="journal.currentIssue"}
				</h2>
			</header>
			<p class="current_issue_title lead">
				{$issue->getIssueIdentification()|strip_unsafe_html}
			</p>
			{include file="frontend/objects/issue_toc.tpl"}
			<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}" class="btn btn-primary read-more">
				{translate key="journal.viewAllIssues"}
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</section>
	</div>
	{/if}


	{* Announcements *}
	{if $numAnnouncementsHomepage && $announcements|count}
	<div class="tab-pane" id="tab-announcement">
		<section class="cmp_announcements media">
			<header class="page-header">
				<h2>
					{translate key="announcement.announcements"}
				</h2>
			</header>
			<div class="media-list">
				{foreach name=announcements from=$announcements item=announcement}
					{if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}
						{break}
					{/if}
					{include file="frontend/objects/announcement_summary.tpl" heading="h3"}
				{/foreach}
			</div>
		</section>
	</div>	
	{/if}

	{* Additional Homepage Content *}
	{if $additionalHomeContent}
	<div class="tab-pane" id="tab-otherinfo">
		<section class="additional_content">
			{$additionalHomeContent}
		</section>
	</div>
	{/if}


</div>



</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
