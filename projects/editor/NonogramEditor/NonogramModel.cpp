#include "NonogramModel.h"

NonogramModel::NonogramModel(QString const & title, QString const & comment)
{
    m_title = title;
    m_comment = comment;
}

QString NonogramModel::Title() const
{
    return m_title;
}

QString NonogramModel::Comment() const
{
    return m_comment;
}
