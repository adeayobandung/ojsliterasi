{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showGalleyLinks bool Show galley links to users without access?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *}
{assign var=articlePath value=$article->getBestArticleId($currentJournal)}
{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<div class="panel panel-info">
  <div class="panel-body">
	<div class="row">
		<div class="col-lg-11 col-md-11 col-sm-11 col-xs-12">
			<a href="{url page="article" op="view" path=$articlePath}">
			<h4 class="maintitle">{$article->getLocalizedTitle()|strip_unsafe_html}</h4>
			{if $article->getLocalizedSubtitle()}
				<p class="subtitle">{$article->getLocalizedSubtitle()|escape}</p>
			{/if}
			</a>
			{if $showAuthor}
				<div class="authors">
					<span class="fa fa-user"></span> {$article->getAuthorString()}
				</div>
			{/if}
		</div>
		<div class="col-lg-1 col-md-1 col-sm-1 col-xs-12 text-center tocnumber">
			{if !$hideGalleys && $article->getGalleys()}
				{foreach from=$article->getGalleys() item=galley}
					{if $primaryGenreIds}
						{assign var="file" value=$galley->getFile()}
						{if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
							{continue}
						{/if}
					{/if}
					{assign var="hasArticleAccess" value=$hasAccess}
					{if ($article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN)}
						{assign var="hasArticleAccess" value=1}
					{/if}
					{include file="frontend/objects/galley_link.tpl" parent=$article hasAccess=$hasArticleAccess}
				{/foreach}
			{/if}		
			{if $article->getPages()}
				<p class="pagenumber">
					<span class="btn btn-default btn-block btn-sm">{$article->getPages()|escape}</span>
				</p>
			{/if}
		</div>
	</div>
  </div>
  <div class="panel-footer">
		<span class="fa fa-calendar"></span>
		{$article->getDatePublished()|date_format:"%Y-%m-%d"}
		&nbsp;
		<span class="fa fa-line-chart"> </span> View : {$article->getViews()} Times
		&nbsp;
		{if is_a($article, 'PublishedArticle')}{assign var=galleys value=$article->getGalleys()}{/if}
		{if $galleys}
			{foreach from=$galleys item=galley name=galleyList}
			<span class="fa fa-bar-chart"> </span> Download : {$galley->getViews()} Times
			{/foreach}
		{/if}  
  </div>
</div>

	{call_hook name="Templates::Issue::Issue::Article"}
