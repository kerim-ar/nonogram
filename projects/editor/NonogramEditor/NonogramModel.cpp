#include "NonogramModel.h"

NonogramModel::NonogramModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

NonogramModel::~NonogramModel()
{
}

int NonogramModel::rowCount(const QModelIndex &parent) const
{
    return m_cells.size();
}

QVariant NonogramModel::data(const QModelIndex &index, int role) const
{
    return QVariant();
}

QString NonogramModel::title() const
{
    return m_title;
}

void NonogramModel::setTitle(const QString &title)
{
    if (m_title != title) {
        m_title = title;
        emit titleChanged();
    }
}

QString NonogramModel::comment() const
{
    return m_comment;
}

void NonogramModel::setComment(const QString &comment)
{
    if (m_comment != comment) {
        m_comment = comment;
        emit commentChanged();
    }
}
