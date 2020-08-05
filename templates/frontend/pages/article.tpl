{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2019 anwar dani
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
  *
 * @uses $article Article This article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $keywords array List of keywords assigned to this article
 * @uses $citationFactory @todo
 * @uses $pubIdPlugins @todo
 *}

{include file="frontend/components/header-article.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

{include file="frontend/components/breadcrumbs_article.tpl"}

{include file="frontend/objects/article_details.tpl"}

{include file="frontend/components/footer-article.tpl"}
